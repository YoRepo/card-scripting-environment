--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 巨星坠  (ID: 43986064)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 不能对应这张卡的发动让不持有等级的怪兽的效果发动。
-- ①：以不持有等级的场上1只表侧表示怪兽为对象才能发动。那只表侧表示怪兽直到回合结束时攻击力变成0，不能把效果发动，不会被战斗破坏。这个回合，那只表侧表示怪兽的战斗发生的对双方的战斗伤害变成一半。
--[[ __CARD_HEADER_END__ ]]

--巨星墜とし
function c43986064.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+TIMINGS_CHECK_MONSTER)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c43986064.target)
	e1:SetOperation(c43986064.activate)
	c:RegisterEffect(e1)
end
function c43986064.filter(c)
	return c:IsFaceup() and c:IsLevel(0)
end
function c43986064.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c43986064.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c43986064.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c43986064.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimit(c43986064.chainlm)
	end
end
function c43986064.chainlm(e,rp,tp)
	return not (e:GetHandler():IsType(TYPE_MONSTER) and e:GetHandler():IsLevel(0))
end
function c43986064.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_TRIGGER)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e3:SetValue(1)
		tc:RegisterEffect(e3)
		local e4=e2:Clone()
		e4:SetCode(EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE)
		e4:SetValue(HALF_DAMAGE)
		tc:RegisterEffect(e4)
	end
end
