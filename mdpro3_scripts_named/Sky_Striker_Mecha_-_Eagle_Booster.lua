--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 闪刀机-鹰式推进器  (ID: 25733157)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 277
--
-- Effect Text:
-- ①：自己的主要怪兽区域没有怪兽存在的场合，以场上1只表侧表示怪兽为对象才能发动。这个回合，那只表侧表示怪兽不受自身以外的卡的效果影响。自己墓地有魔法卡3张以上存在的场合，再在这个回合让那只怪兽不会被战
-- 斗破坏。
--[[ __CARD_HEADER_END__ ]]

--閃刀機－イーグルブースター
function c25733157.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c25733157.condition)
	e1:SetTarget(c25733157.target)
	e1:SetOperation(c25733157.activate)
	c:RegisterEffect(e1)
end
function c25733157.cfilter(c)
	return c:GetSequence()<5
end
function c25733157.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c25733157.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c25733157.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c25733157.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(c25733157.efilter)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		if Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL)>=3 then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
		end
	end
end
function c25733157.efilter(e,re)
	return e:GetHandler()~=re:GetOwner()
end
