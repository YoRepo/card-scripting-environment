--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 廷达魔三角之底边守卫者  (ID: 94365540)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 5
-- ATK 0 | DEF 2300
-- Setcode: 267
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：自己场上有里侧守备表示怪兽存在的场合，这张卡可以从手卡守备表示特殊召唤。
-- ②：这张卡已在怪兽区域存在的状态，对方的连接怪兽的所连接区有怪兽召唤·特殊召唤的场合，把这张卡解放才能发动。从手卡·卡组把1只「廷达魔三角」怪兽表侧攻击表示或者里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ティンダングル・ベース・ガードナー
function c94365540.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetCountLimit(1,94365540+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c94365540.condition)
	c:RegisterEffect(e1)
	--Special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(94365540,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c94365540.spcost)
	e2:SetCondition(c94365540.spcon)
	e2:SetTarget(c94365540.sptg)
	e2:SetOperation(c94365540.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c94365540.filter(c)
	return c:IsFacedown()
end
function c94365540.condition(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c94365540.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c94365540.cfilter(c,tp,zone)
	local seq=c:GetSequence()
	if c:IsLocation(LOCATION_MZONE) then
		if c:IsControler(1-tp) then seq=seq+16 end
	else
		seq=c:GetPreviousSequence()
		if c:IsPreviousControler(1-tp) then seq=seq+16 end
	end
	return bit.extract(zone,seq)~=0
end
function c94365540.lkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
function c94365540.spcon(e,tp,eg,ep,ev,re,r,rp)
	local zone=0
	local lg=Duel.GetMatchingGroup(c94365540.lkfilter,tp,0,LOCATION_MZONE,nil)
	for tc in aux.Next(lg) do
		zone=bit.bor(zone,tc:GetLinkedZone(tp))
	end
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c94365540.cfilter,1,nil,tp,zone)
end
function c94365540.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c94365540.spfilter(c,e,tp)
	return c:IsSetCard(0x10b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)
end
function c94365540.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c94365540.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c94365540.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c94365540.spfilter),tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)~=0 and tc:IsFacedown() then
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end
