--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 清透恶龙  (ID: 97811903)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK ? | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，「清透世界」的效果对自己不适用。
-- ②：这张卡的攻击力只在向对方怪兽攻击的伤害计算时变成那只对方怪兽的攻击力的2倍。
-- ③：场上的这张卡被对方的效果破坏的场合，可以作为代替把自己1张手卡丢弃。
--[[ __CARD_HEADER_END__ ]]

--クリアー・バイス・ドラゴン
function c97811903.initial_effect(c)
	aux.AddCodeList(c,33900648)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c97811903.atkcon)
	e1:SetValue(c97811903.atkval)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetTarget(c97811903.reptg)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(1,0)
	e3:SetCode(97811903)
	c:RegisterEffect(e3)
end
function c97811903.atkcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL
		and e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()
end
function c97811903.atkval(e,c)
	return Duel.GetAttackTarget():GetAttack()*2
end
function c97811903.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp
		and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
		return true
	else return false end
end
