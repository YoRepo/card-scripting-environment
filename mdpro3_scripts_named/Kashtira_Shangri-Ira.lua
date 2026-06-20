--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 俱舍怒威族的香格里拉茧  (ID: 73542331)
-- Type: Monster / Effect / Xyz
-- Attribute: FIRE
-- Race: Psychic
-- Rank 7
-- ATK 0 | DEF 3000
-- Setcode: 393
--
-- Effect Text:
-- 7星怪兽×2只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己·对方的准备阶段才能发动。从卡组把1只「俱舍怒威族」怪兽特殊召唤。
-- ②：每次对方的卡被里侧表示除外，指定没有使用的主要怪兽区域或者魔法与陷阱区域1处才能发动。指定的区域在这只怪兽表侧表示存在期间不能使用。
-- ③：场上的这张卡被战斗·效果破坏的场合，可以作为代替把这张卡1个超量素材取除。
--[[ __CARD_HEADER_END__ ]]

--クシャトリラ・シャングリラ
function c73542331.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,7,2,nil,nil,99)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(73542331,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,73542331)
	e1:SetTarget(c73542331.sptg)
	e1:SetOperation(c73542331.spop)
	c:RegisterEffect(e1)
	--lock zones
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(73542331,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCondition(c73542331.lzcon)
	e2:SetTarget(c73542331.lztg)
	e2:SetOperation(c73542331.lzop)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetTarget(c73542331.reptg)
	c:RegisterEffect(e3)
end
function c73542331.spfilter(c,e,tp)
	return c:IsSetCard(0x189) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c73542331.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c73542331.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c73542331.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c73542331.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c73542331.cfilter(c,tp)
	return c:IsFacedown() and c:IsControler(1-tp) and c:IsPreviousControler(1-tp)
end
function c73542331.lzcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c73542331.cfilter,1,nil,tp)
end
function c73542331.lztg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)
		+Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)
		+Duel.GetLocationCount(tp,LOCATION_SZONE,PLAYER_NONE,0)
		+Duel.GetLocationCount(1-tp,LOCATION_SZONE,PLAYER_NONE,0)>0 end
	local dis=Duel.SelectDisableField(tp,1,LOCATION_ONFIELD,LOCATION_ONFIELD,0xe000e0)
	Duel.SetTargetParam(dis)
	Duel.Hint(HINT_ZONE,tp,dis)
end
function c73542331.lzop(e,tp,eg,ep,ev,re,r,rp)
	local zone=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if tp==1 then
		zone=((zone&0xffff)<<16)|((zone>>16)&0xffff)
	end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetValue(zone)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function c73542331.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE) and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
