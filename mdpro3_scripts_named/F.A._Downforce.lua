--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 方程式运动员下压力  (ID: 66322203)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 263
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以自己场上1只「方程式运动员」怪兽为对象才能发动。那只怪兽的等级直到回合结束时上升2星。
-- ②：自己主要阶段把墓地的这张卡除外，以自己场上1只「方程式运动员」怪兽为对象才能发动。那只怪兽的等级直到回合结束时上升2星。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--F.A.ダウンフォース
function c66322203.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,66322203)
	e1:SetHintTiming(TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c66322203.target)
	e1:SetOperation(c66322203.operation)
	c:RegisterEffect(e1)
	--grave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,66322204)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c66322203.target)
	e2:SetOperation(c66322203.operation)
	c:RegisterEffect(e2)
end
function c66322203.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x107) and c:IsLevelAbove(1)
end
function c66322203.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c66322203.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66322203.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c66322203.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c66322203.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(2)
		tc:RegisterEffect(e1)
	end
end
