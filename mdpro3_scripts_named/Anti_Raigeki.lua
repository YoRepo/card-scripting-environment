--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 避雷针  (ID: 42364257)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方使用了「雷击」的时候，破坏对方全部怪兽代替自己的怪兽。发动后这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--避雷針
function c42364257.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c42364257.condition)
	e1:SetTarget(c42364257.target)
	e1:SetOperation(c42364257.activate)
	c:RegisterEffect(e1)
end
function c42364257.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(12580477) and Duel.IsChainDisablable(ev)
end
function c42364257.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c42364257.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) then
		local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
