--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 破灭之天使 露茵  (ID: 50139096)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1700 | DEF 1000
--
-- Effect Text:
-- 「世界不灭」降临。
-- ①：这张卡的卡名只要在手卡·场上存在当作「破灭之女神 露茵」使用。
-- ②：这张卡仪式召唤成功的场合发动。这个回合，这张卡在同1次的战斗阶段中最多2次可以向怪兽攻击。
-- ③：这张卡被送去墓地的场合，以自己场上1只仪式怪兽为对象才能发动。只要那只怪兽在自己场上表侧表示存在，在自己的仪式怪兽的攻击宣言时对方不能把卡的效果发动。
--[[ __CARD_HEADER_END__ ]]

--破滅の天使ルイン
function c50139096.initial_effect(c)
	aux.AddCodeList(c,32828635)
	c:EnableReviveLimit()
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetDescription(aux.Stringid(50139096,0))
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c50139096.atkcon)
	e1:SetOperation(c50139096.atkop)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(50139096,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetTarget(c50139096.target)
	e2:SetOperation(c50139096.operation)
	c:RegisterEffect(e2)
	--name change
	aux.EnableChangeCode(c,46427957,LOCATION_MZONE+LOCATION_HAND)
end
function c50139096.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c50139096.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c50139096.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL)
end
function c50139096.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c50139096.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c50139096.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c50139096.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c50139096.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ATTACK_ANNOUNCE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(c50139096.actcon)
		e1:SetOperation(c50139096.actop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(50139096,2))
	end
end
function c50139096.actcon(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetAttacker()
	return ac and ac:IsControler(tp) and ac:IsType(TYPE_RITUAL)
end
function c50139096.actop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
