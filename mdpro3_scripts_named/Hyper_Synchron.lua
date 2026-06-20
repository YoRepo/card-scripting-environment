--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 高超同调士  (ID: 40348946)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1600 | DEF 800
-- Setcode: 4119
--
-- Effect Text:
-- 这张卡被龙族怪兽的同调召唤使用送去墓地的场合，这张卡为同调素材的同调怪兽的攻击力上升800，结束阶段时从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--ハイパー・シンクロン
function c40348946.initial_effect(c)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40348946,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c40348946.con)
	e1:SetTarget(c40348946.tg)
	e1:SetOperation(c40348946.op)
	c:RegisterEffect(e1)
	aux.CreateMaterialReasonCardRelation(c,e1)
end
function c40348946.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO and c:GetReasonCard():IsRace(RACE_DRAGON)
end
function c40348946.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local rc=e:GetHandler():GetReasonCard()
	if chk==0 then return rc:IsRelateToEffect(e) and rc:IsFaceup() end
	Duel.SetTargetCard(rc)
end
function c40348946.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sync=Duel.GetFirstTarget()
	if not sync:IsRelateToChain() or sync:IsFacedown() or sync:IsImmuneToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(800)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	sync:RegisterEffect(e1)
	sync:RegisterFlagEffect(40348946,RESET_EVENT+RESETS_STANDARD,0,1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCountLimit(1)
	e2:SetLabelObject(sync)
	e2:SetCondition(c40348946.rmcon)
	e2:SetOperation(c40348946.rmop)
	Duel.RegisterEffect(e2,tp)
end
function c40348946.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(40348946)~=0 then
		return true
	else
		e:Reset()
		return false
	end
end
function c40348946.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
