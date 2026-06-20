--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 魔法效果之矢  (ID: 93260132)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方场上的表侧表示的魔法卡全部破坏，给与对方破坏数量×500伤害。
--[[ __CARD_HEADER_END__ ]]

--魔法効果の矢
function c93260132.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c93260132.target)
	e1:SetOperation(c93260132.activate)
	c:RegisterEffect(e1)
end
function c93260132.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL)
end
function c93260132.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c93260132.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(c93260132.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,sg:GetCount()*500)
end
function c93260132.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c93260132.filter,tp,0,LOCATION_ONFIELD,nil)
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	Duel.Damage(1-tp,ct*500,REASON_EFFECT)
end
