--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 斩机 乘武  (ID: 52354896)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Cyberse
-- Level 4
-- ATK 500 | DEF 2000
-- Setcode: 306
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以自己场上1只电子界族·4星怪兽为对象才能发动。那只怪兽的等级直到回合结束时变成8星。
-- ②：这张卡被送去墓地的场合，以额外怪兽区域1只自己的电子界族怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时变成2倍。
--[[ __CARD_HEADER_END__ ]]

--斬機マルチプライヤー
function c52354896.initial_effect(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,52354896)
	e1:SetTarget(c52354896.target)
	e1:SetOperation(c52354896.operation)
	c:RegisterEffect(e1)
	--double attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,52354897)
	e2:SetTarget(c52354896.datg)
	e2:SetOperation(c52354896.daop)
	c:RegisterEffect(e2)
end
function c52354896.filter(c)
	return c:IsFaceup() and c:IsLevel(4) and c:IsRace(RACE_CYBERSE)
end
function c52354896.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c52354896.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c52354896.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c52354896.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c52354896.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(8)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c52354896.dafilter(c)
	return c:IsFaceup() and c:IsRace(RACE_CYBERSE) and c:GetSequence()>=5
end
function c52354896.datg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c52354896.dafilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c52354896.dafilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c52354896.dafilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c52354896.daop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(atk*2)
		tc:RegisterEffect(e1)
	end
end
