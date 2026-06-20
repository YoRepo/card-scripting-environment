--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 大十字  (ID: 38430673)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有「大宇宙」存在时才能发动。给与对方基本分300分伤害，场上的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--グランドクロス
function c38430673.initial_effect(c)
	aux.AddCodeList(c,30241314)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c38430673.condition)
	e1:SetTarget(c38430673.target)
	e1:SetOperation(c38430673.activate)
	c:RegisterEffect(e1)
end
function c38430673.filter(c)
	return c:IsFaceup() and c:IsCode(30241314)
end
function c38430673.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c38430673.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c38430673.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c38430673.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,300,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
