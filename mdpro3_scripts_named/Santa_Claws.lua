--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 撒旦老人  (ID: 46565218)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level 6
-- ATK 1200 | DEF 2500
--
-- Effect Text:
-- ①：这张卡可以把对方场上1只怪兽解放，从手卡往对方场上守备表示特殊召唤。
-- ②：这张卡用这张卡的①的方法特殊召唤的回合的结束阶段才能发动。自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--サタンクロース
function c46565218.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,1)
	e1:SetCondition(c46565218.spcon)
	e1:SetTarget(c46565218.sptg)
	e1:SetOperation(c46565218.spop)
	c:RegisterEffect(e1)
end
function c46565218.spfilter(c,tp)
	return c:IsReleasable(REASON_SPSUMMON) and Duel.GetMZoneCount(1-tp,c,tp)>0
end
function c46565218.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c46565218.spfilter,tp,0,LOCATION_MZONE,1,nil,tp)
end
function c46565218.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c46565218.spfilter,tp,0,LOCATION_MZONE,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c46565218.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46565218,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetTarget(c46565218.drtg)
	e1:SetOperation(c46565218.drop)
	e1:SetReset(RESET_EVENT+0xec0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
function c46565218.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c46565218.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
