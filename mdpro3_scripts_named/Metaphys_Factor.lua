--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 玄化因子  (ID: 20720928)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 261
--
-- Effect Text:
-- ①：只要这张卡在场地区域存在，自己在5星以上的「玄化」怪兽召唤的场合需要的解放可以不用。这个效果1回合只能适用1次。这个效果适用召唤的怪兽在下个回合的结束阶段除外。
-- ②：只要这张卡在场地区域存在，对方不能对应自己的「玄化」怪兽的效果的发动把魔法·陷阱·怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--メタファイズ・ファクター
function c20720928.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--decrease tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20720928,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCountLimit(1)
	e2:SetCondition(c20720928.ntcon)
	e2:SetTarget(c20720928.nttg)
	e2:SetOperation(c20720928.ntop)
	c:RegisterEffect(e2)
	--act limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_FZONE)
	e3:SetOperation(c20720928.chainop)
	c:RegisterEffect(e3)
end
function c20720928.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c20720928.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsSetCard(0x105)
end
function c20720928.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	c:RegisterFlagEffect(20720928,RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(20720928,1))
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetLabel(Duel.GetTurnCount()+1)
	e2:SetLabelObject(c)
	e2:SetCondition(c20720928.rmcon)
	e2:SetOperation(c20720928.rmop)
	e2:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e2,tp)
end
function c20720928.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(20720928)~=0 then
		return Duel.GetTurnCount()==e:GetLabel()
	else
		e:Reset()
		return false
	end
end
function c20720928.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c20720928.chainop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsSetCard(0x105) and re:IsActiveType(TYPE_MONSTER) and ep==tp then
		Duel.SetChainLimit(c20720928.chainlm)
	end
end
function c20720928.chainlm(e,rp,tp)
	return tp==rp
end
