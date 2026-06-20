--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 未来驱力  (ID: 12508268)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己场上1只「未来皇 霍普」超量怪兽为对象才能发动。这个回合，那只自己怪兽受以下效果适用。
-- ●那只怪兽可以向对方怪兽全部各作1次攻击。
-- ●那只怪兽和对方怪兽进行战斗的伤害步骤内，那只对方怪兽的效果无效化。
-- ●每次那只怪兽战斗破坏对方怪兽，给与对方那只破坏的怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--フューチャー・ドライブ
function c12508268.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,12508268+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c12508268.target)
	e1:SetOperation(c12508268.activate)
	c:RegisterEffect(e1)
end
function c12508268.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x207f)
end
function c12508268.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c12508268.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c12508268.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c12508268.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c12508268.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) then return end
	tc:RegisterFlagEffect(12508268,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1,tc:GetFieldID())
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetCondition(c12508268.atkcon)
	e1:SetOwnerPlayer(tp)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetLabelObject(tc)
	e2:SetCondition(c12508268.discon)
	e2:SetOperation(c12508268.disop)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetReset(RESET_PHASE+PHASE_END)
	e3:SetLabelObject(tc)
	e3:SetCondition(c12508268.damcon)
	e3:SetOperation(c12508268.damop)
	Duel.RegisterEffect(e3,tp)
end
function c12508268.atkcon(e)
	return e:GetHandlerPlayer()==e:GetOwnerPlayer()
end
function c12508268.discon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local fid=tc:GetFlagEffectLabel(12508268)
	return fid and fid==tc:GetFieldID()
end
function c12508268.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ac=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	local tc=e:GetLabelObject()
	if not ac or not bc then return end
	if ac~=tc then ac,bc=bc,ac end
	if ac==tc and bc:IsControler(1-tp) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		bc:RegisterEffect(e2)
	end
end
function c12508268.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local fid=tc:GetFlagEffectLabel(12508268)
	local bc=tc:GetBattleTarget()
	return fid and fid==tc:GetFieldID() and tc==eg:GetFirst() and tc:IsRelateToBattle() and bc and bc:IsPreviousControler(1-tp)
end
function c12508268.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local bc=tc:GetBattleTarget()
	if not bc then return end
	local dam=math.max(bc:GetBaseAttack(),0)
	if dam>0 then
		Duel.Hint(HINT_CARD,0,12508268)
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end
