--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 地狱暴风  (ID: 14391920)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己受到3000以上的战斗伤害时才能发动。双方的卡组·墓地的怪兽全部除外。
--[[ __CARD_HEADER_END__ ]]

--ヘル・テンペスト
function c14391920.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c14391920.condition)
	e1:SetTarget(c14391920.target)
	e1:SetOperation(c14391920.activate)
	c:RegisterEffect(e1)
end
function c14391920.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and ev>=3000
end
function c14391920.chkfilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsAbleToRemove()
end
function c14391920.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c14391920.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.IsExistingMatchingCard(c14391920.filter,tp,LOCATION_DECK+LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
			and not Duel.IsExistingMatchingCard(c14391920.chkfilter,tp,LOCATION_DECK+LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c14391920.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c14391920.filter,tp,LOCATION_DECK+LOCATION_GRAVE,LOCATION_DECK+LOCATION_GRAVE,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end
