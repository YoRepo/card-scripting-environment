--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 变形斗士·照明灯  (ID: 76865611)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Machine
-- Level 1
-- ATK 200 | DEF 200
-- Setcode: 38
--
-- Effect Text:
-- 这张卡得到这张卡的表示形式的以下效果。
-- ●攻击表示：只要这张卡在场上表侧表示存在，对方的卡的效果发生的对自己的效果伤害由对方代受。
-- ●守备表示：这张卡被战斗破坏送去墓地时，这个回合战斗发生的对自己的战斗伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--D・ライトン
function c76865611.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c76865611.cona)
	e1:SetTargetRange(1,0)
	e1:SetValue(c76865611.refval)
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetOperation(c76865611.check)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(76865611,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetCondition(c76865611.cond)
	e3:SetOperation(c76865611.opd)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c76865611.cona(e)
	return e:GetHandler():IsAttackPos()
end
function c76865611.refval(e,re,val,r,rp,rc)
	return rp==1-e:GetHandlerPlayer() and bit.band(r,REASON_EFFECT)~=0
end
function c76865611.check(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsDisabled() and c:IsDefensePos() then e:SetLabel(1)
	else e:SetLabel(0) end
end
function c76865611.cond(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()==1
		and e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c76865611.opd(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
