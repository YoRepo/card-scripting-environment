--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 第二次机会  (ID: 36562627)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能适用1次。
-- ①：自己进行投掷硬币的效果适用之际，可以从最初开始重新投掷硬币。
--[[ __CARD_HEADER_END__ ]]

--セカンド・チャンス
function c36562627.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--coin
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TOSS_COIN_NEGATE)
	e2:SetCondition(c36562627.coincon)
	e2:SetOperation(c36562627.coinop)
	c:RegisterEffect(e2)
end
function c36562627.coincon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFlagEffect(tp,36562627)==0
end
function c36562627.coinop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,36562627)~=0 then return end
	if Duel.SelectYesNo(tp,aux.Stringid(36562627,0)) then
		Duel.Hint(HINT_CARD,0,36562627)
		Duel.RegisterFlagEffect(tp,36562627,RESET_PHASE+PHASE_END,0,1)
		Duel.TossCoin(tp,ev)
	end
end
