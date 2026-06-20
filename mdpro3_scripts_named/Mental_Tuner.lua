--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 精神调整员  (ID: 30291086)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Psychic
-- Level 3
-- ATK 200 | DEF 2100
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：可以从以下效果选择1个发动。
-- ●把光·暗属性怪兽各最多1只从自己的手卡·墓地除外才能发动。直到回合结束时这张卡的等级上升或者下降除外数量的数值。
-- ●以除外的自己的光·暗属性怪兽各最多1只为对象才能发动。那些怪兽回到墓地，直到回合结束时这张卡的等级上升或者下降回去数量的数值。
--[[ __CARD_HEADER_END__ ]]

--メンタル・チューナー
local s,id,o=GetID()
function s.initial_effect(c)
	--level up/down
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,4))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.lvtg)
	c:RegisterEffect(e1)
end
function s.costfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
		and c:IsAbleToRemoveAsCost()
end
function s.tgfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
		and c:IsFaceup() and c:IsAbleToGrave()
end
function s.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and s.tgfilter(chkc) end
	local b1=Duel.IsExistingMatchingCard(s.costfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil)
	local b2=Duel.IsExistingTarget(s.tgfilter,tp,LOCATION_REMOVED,0,1,nil)
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(id,0),aux.Stringid(id,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(id,0))
	else
		op=Duel.SelectOption(tp,aux.Stringid(id,1))+1
	end
	if op==0 then
		e:SetProperty(0)
		e:SetCategory(0)
		local g=Duel.GetMatchingGroup(s.costfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=g:SelectSubGroup(tp,aux.dabcheck,false,1,2)
		Duel.Remove(sg,POS_FACEUP,REASON_COST)
		e:SetLabel(#sg)
		e:SetOperation(s.lvop1)
	else
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetCategory(CATEGORY_TOGRAVE)
		local g=Duel.GetMatchingGroup(s.tgfilter,tp,LOCATION_REMOVED,0,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:SelectSubGroup(tp,aux.dabcheck,false,1,2)
		Duel.SetTargetCard(sg)
		e:SetOperation(s.lvop2)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	end
end
function s.lvop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local lv=e:GetLabel()
	local op=0
	if c:IsLevelBelow(lv) then
		op=Duel.SelectOption(tp,aux.Stringid(id,2))
	else
		op=Duel.SelectOption(tp,aux.Stringid(id,2),aux.Stringid(id,3))
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	if op==0 then
		e1:SetValue(lv)
	else
		e1:SetValue(-lv)
	end
	c:RegisterEffect(e1)
end
function s.lvop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetTargetsRelateToChain()
	if #g>0 and Duel.SendtoGrave(g,REASON_EFFECT+REASON_RETURN)>0
		and c:IsFaceup() and c:IsRelateToEffect(e) then
		local lv=Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
		local op=0
		if c:IsLevelBelow(lv) then
			op=Duel.SelectOption(tp,aux.Stringid(id,2))
		else
			op=Duel.SelectOption(tp,aux.Stringid(id,2),aux.Stringid(id,3))
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		if op==0 then
			e1:SetValue(lv)
		else
			e1:SetValue(-lv)
		end
		c:RegisterEffect(e1)
	end
end
