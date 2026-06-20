--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 璃拉说唱  (ID: 72233469)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 339
--
-- Effect Text:
-- 这个卡名的效果在同一连锁上只能发动1次。
-- ①：1回合1次，自己从墓地把怪兽特殊召唤的场合才能发动。对方失去1000基本分，自己回复500基本分。
--[[ __CARD_HEADER_END__ ]]

--リィラップ
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--change LP
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(s.lpcon)
	e1:SetTarget(s.lptg)
	e1:SetOperation(s.lpop)
	c:RegisterEffect(e1)
end
function s.filter(c,tp)
	return c:IsSummonLocation(LOCATION_GRAVE) and c:IsSummonPlayer(tp) and c:GetOriginalType()&TYPE_MONSTER~=0
end
function s.lpcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.filter,1,nil,tp)
end
function s.lptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 end
	Duel.RegisterFlagEffect(tp,id,RESET_CHAIN,0,1)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function s.lpop(e,tp,eg,ep,ev,re,r,rp)
	local lp=Duel.GetLP(1-tp)
	Duel.SetLP(1-tp,lp-1000)
	if Duel.GetLP(1-tp)<lp then Duel.Recover(tp,500,REASON_EFFECT) end
end
