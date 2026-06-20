--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 再世十戒  (ID: 95382988)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 453
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：和自己场上的「再世」怪兽相同纵列的对方场上的全部卡受以下效果适用。
-- ●表侧表示卡：效果无效化。
-- ●里侧表示怪兽：不能把表示形式变更。
-- ●里侧表示的魔法·陷阱卡：直到下个回合的结束时不能发动。
--[[ __CARD_HEADER_END__ ]]

--再世十戒
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.cfilter(c,tp)
	local g=c:GetColumnGroup():Filter(Card.IsControler,nil,1-tp)
	return c:IsFaceup() and c:IsSetCard(0x1c5)
		and g:IsExists(s.dfilter,1,nil)
end
function s.dfilter(c)
	if c:IsFaceup() then
		return aux.NegateAnyFilter(c)
	elseif c:IsFacedown() then
		return true
	end
	return false
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
end
function s.dop(c,e)
	if c:IsFaceup() and aux.NegateAnyFilter(c) and c:IsCanBeDisabledByEffect(e,false) then
		Duel.NegateRelatedChain(c,RESET_TURN_SET)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		c:RegisterEffect(e2)
		if c:IsType(TYPE_TRAPMONSTER) then
			local e3=e1:Clone()
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			c:RegisterEffect(e3)
		end
	end
	if c:IsFacedown() and c:IsType(TYPE_MONSTER) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	elseif c:IsFacedown() and c:IsType(TYPE_SPELL+TYPE_TRAP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		c:RegisterEffect(e1)
	end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_MZONE,0,nil,tp)
	if g:GetCount()==0 then return end
	local sg=Group.CreateGroup()
	for tc in aux.Next(g) do
		local tg=tc:GetColumnGroup():Filter(Card.IsControler,nil,1-tp)
		Group.Merge(sg,tg)
	end
	for oc in aux.Next(sg) do
		s.dop(oc,e)
	end
end
