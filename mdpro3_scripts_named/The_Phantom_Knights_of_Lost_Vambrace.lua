--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: The Phantom Knights of Lost Vambrace  (ID: 36247316)
-- Type: Trap
-- Setcode: 0x10db
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 face-up monster on the field; if that target is still face-up on the field, "The Phantom
-- Knights" monsters you control cannot be destroyed by battle, also that target loses 600 ATK, also
-- its Level becomes 2.
-- These effects last until the end of this turn.
-- Then, Special Summon this card in Defense Position as a Normal Monster (Warrior/DARK/Level 2/ATK
-- 600/DEF 0).
-- (This card is NOT treated as a Trap.)
--[[ __CARD_HEADER_END__ ]]

--幻影騎士団ロスト・ヴァンブレイズ
function c36247316.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c36247316.target)
	e1:SetOperation(c36247316.activate)
	c:RegisterEffect(e1)
end
function c36247316.filter(c)
	return c:GetLevel()>0 and c:IsFaceup()
end
function c36247316.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c36247316.filter(chkc) end
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,36247316,0x10db,TYPES_NORMAL_TRAP_MONSTER,600,0,2,RACE_WARRIOR,ATTRIBUTE_DARK)
		and Duel.IsExistingTarget(c36247316.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c36247316.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c36247316.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-600)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_LEVEL)
		e2:SetValue(2)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e3:SetTargetRange(LOCATION_MZONE,0)
		e3:SetTarget(c36247316.indtarget)
		e3:SetValue(1)
		e3:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e3,tp)
		if c:IsRelateToEffect(e)
			and Duel.IsPlayerCanSpecialSummonMonster(tp,36247316,0x10db,TYPES_NORMAL_TRAP_MONSTER,600,0,2,RACE_WARRIOR,ATTRIBUTE_DARK) then
			Duel.BreakEffect()
			c:AddMonsterAttribute(TYPE_NORMAL)
			Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
		end
	end
end
function c36247316.indtarget(e,c)
	return c:IsFaceup() and c:IsSetCard(0x10db)
end
