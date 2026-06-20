--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 觉醒战士 库丘林  (ID: 10789972)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 500 | DEF 1000
--
-- Effect Text:
-- 「觉醒之证」降临。1回合1次，选择自己墓地存在的1只通常怪兽才能发动。选择的怪兽从游戏中除外，直到下次的自己回合的准备阶段时这张卡的攻击力上升除外的那只通常怪兽的攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--覚醒戦士 クーフーリン
function c10789972.initial_effect(c)
	aux.AddCodeList(c,9845733)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10789972,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c10789972.target)
	e1:SetOperation(c10789972.operation)
	c:RegisterEffect(e1)
end
function c10789972.filter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToRemove()
end
function c10789972.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c10789972.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10789972.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c10789972.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,tp,LOCATION_GRAVE)
end
function c10789972.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_STANDBY,2)
		c:RegisterEffect(e1)
	end
end
