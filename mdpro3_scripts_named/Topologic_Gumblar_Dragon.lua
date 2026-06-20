--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 拓扑篡改感染龙  (ID: 22593417)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- ATK 3000 | LINK
-- Setcode: 366
--
-- Effect Text:
-- 效果怪兽2只以上
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡已在怪兽区域存在的状态，这张卡以外的怪兽在连接怪兽所连接区特殊召唤的场合发动。自己把手卡任意数量随机丢弃（最多2张）。那之后，对方选丢弃数量的手卡丢弃。
-- ②：这张卡是额外连接状态的场合才能发动。对方尽可能选最多2张手卡丢弃。这个效果让对方手卡变成0张的场合，再给与对方3000伤害。
--[[ __CARD_HEADER_END__ ]]

--トポロジック・ガンブラー・ドラゴン
function c22593417.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2)
	c:EnableReviveLimit()
	--discard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22593417,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,22593417)
	e1:SetCondition(c22593417.hdcon)
	e1:SetTarget(c22593417.hdtg)
	e1:SetOperation(c22593417.hdop)
	c:RegisterEffect(e1)
	--discard
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22593417,1))
	e2:SetCategory(CATEGORY_HANDES+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,22593417)
	e2:SetCondition(c22593417.hdcon2)
	e2:SetTarget(c22593417.hdtg2)
	e2:SetOperation(c22593417.hdop2)
	c:RegisterEffect(e2)
end
function c22593417.cfilter(c,zone)
	local seq=c:GetSequence()
	if c:IsControler(1) then seq=seq+16 end
	return bit.extract(zone,seq)~=0
end
function c22593417.hdcon(e,tp,eg,ep,ev,re,r,rp)
	local zone=Duel.GetLinkedZone(0)+Duel.GetLinkedZone(1)*0x10000
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c22593417.cfilter,1,nil,zone)
end
function c22593417.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c22593417.hdop(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local ct=math.min(hg:GetCount(),2)
	if ct<=0 then return end
	local ct2=1
	if ct>1 then ct2=Duel.AnnounceNumber(tp,1,2) end
	local g=hg:RandomSelect(tp,ct2)
	local ct3=Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	if ct3<=0 then return end
	Duel.BreakEffect()
	Duel.DiscardHand(1-tp,nil,ct3,ct3,REASON_EFFECT+REASON_DISCARD)
end
function c22593417.hdcon2(e)
	return e:GetHandler():IsExtraLinkState()
end
function c22593417.hdtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,2)
end
function c22593417.hdop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(1-tp,nil,2,2,REASON_EFFECT+REASON_DISCARD)~=0
		and Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)==0 then
		Duel.Damage(1-tp,3000,REASON_EFFECT)
	end
end
