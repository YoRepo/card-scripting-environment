--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 盾虫  (ID: 15939448)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 4
-- ATK 800 | DEF 2000
-- Setcode: 62
--
-- Effect Text:
-- 这张卡召唤·反转召唤·特殊召唤成功时，变成守备表示。再把自己场上表侧表示存在的昆虫族怪兽数量的卡从对方卡组上面送去墓地。
--[[ __CARD_HEADER_END__ ]]

--シールド・ワーム
function c15939448.initial_effect(c)
	--deckdes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15939448,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c15939448.condition)
	e1:SetTarget(c15939448.target)
	e1:SetOperation(c15939448.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c15939448.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c15939448.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c15939448.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c15939448.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,ct)
end
function c15939448.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) and Duel.ChangePosition(c,POS_FACEUP_DEFENSE)~=0 then
		local ct=Duel.GetMatchingGroupCount(c15939448.filter,tp,LOCATION_MZONE,0,nil)
		if ct>0 then
			Duel.BreakEffect()
			Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
		end
	end
end
