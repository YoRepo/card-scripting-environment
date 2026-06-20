--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 网球小爱神  (ID: 1566817)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 2
-- ATK 1000 | DEF 600
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能有1次。
-- ①：这张卡只要在怪兽区域存在，不受除持有这张卡的等级以下的等级的怪兽以外的全部怪兽发动的效果影响。
-- ②：把自己墓地最多3张卡除外才能发动。直到回合结束时，这张卡的等级上升除外数量的数值。
--[[ __CARD_HEADER_END__ ]]

--テイ・キューピット
function c1566817.initial_effect(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c1566817.immval)
	c:RegisterEffect(e1)
	--level up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1566817,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,1566817)
	e2:SetCost(c1566817.lvcost)
	e2:SetOperation(c1566817.lvop)
	c:RegisterEffect(e2)
end
function c1566817.immval(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:IsActivated() and (not (e:GetHandler():GetLevel()>=te:GetOwner():GetLevel()) or te:GetOwner():GetLevel()==0)
end
function c1566817.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local sg=g:Select(tp,1,3,nil)
	e:SetLabel(Duel.Remove(sg,POS_FACEUP,REASON_COST))
end
function c1566817.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(ct)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
