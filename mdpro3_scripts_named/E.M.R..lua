--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 电磁轨道炮  (ID: 17427333)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：把自己场上1只机械族怪兽解放，以解放的怪兽的原本攻击力每1000最多1张的场上的卡为对象才能发动。那些卡破坏。
--[[ __CARD_HEADER_END__ ]]

--E.M.R.
function c17427333.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c17427333.cost)
	e1:SetTarget(c17427333.target)
	e1:SetOperation(c17427333.operation)
	c:RegisterEffect(e1)
end
function c17427333.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		e:SetLabel(100)
		return true
	end
end
function c17427333.costfilter(c,tp)
	return c:IsRace(RACE_MACHINE) and (c:IsControler(tp) or c:IsFaceup()) and c:GetTextAttack()>=1000
		and Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
end
function c17427333.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c17427333.costfilter,1,nil,tp)
	end
	local g=Duel.SelectReleaseGroup(tp,c17427333.costfilter,1,1,nil,tp)
	local atk=g:GetFirst():GetTextAttack()
	Duel.Release(g,REASON_COST)
	local ct=math.floor(atk/1000)
	local exc=nil
	if not e:GetHandler():IsStatus(STATUS_EFFECT_ENABLED) then exc=e:GetHandler() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,ct,exc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
end
function c17427333.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
