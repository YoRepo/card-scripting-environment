--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 真超级量子机神王 烈辉大炎磁  (ID: 95493471)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Machine
-- ATK 2500 | LINK
-- Setcode: 220
--
-- Effect Text:
-- 包含「超级量子」怪兽的效果怪兽2只以上
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：连接召唤的这张卡不会被对方的效果破坏。
-- ②：每次有同名卡不在自己场上存在的「超级量子」超量怪兽从额外卡组往这张卡所连接区特殊召唤发动。自己从卡组抽1张。
-- ③：这张卡所连接区的超量怪兽被战斗或者对方的效果破坏的场合才能发动。原本属性和那只超量怪兽相同的1只「超级量子」怪兽从卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--真超量機神王ブラスター・マグナ
function c95493471.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,99,c95493471.lcheck)
	c:EnableReviveLimit()
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetCondition(c95493471.indcon)
	e1:SetValue(aux.indoval)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95493471,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c95493471.drcon)
	e2:SetTarget(c95493471.drtg)
	e2:SetOperation(c95493471.drop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95493471,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,95493471)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c95493471.spcon)
	e3:SetTarget(c95493471.sptg)
	e3:SetOperation(c95493471.spop)
	c:RegisterEffect(e3)
end
function c95493471.lcheck(g)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0xdc)
end
function c95493471.indcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c95493471.cfilter(c,lg,tp)
	return c:IsSetCard(0xdc) and c:IsType(TYPE_XYZ) and c:IsSummonLocation(LOCATION_EXTRA) and lg:IsContains(c)
		and not Duel.IsExistingMatchingCard(c95493471.drfilter,tp,LOCATION_MZONE,0,1,c,c:GetCode())
end
function c95493471.drfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c95493471.drcon(e,tp,eg,ep,ev,re,r,rp)
	local lg=e:GetHandler():GetLinkedGroup()
	return eg:IsExists(c95493471.cfilter,1,nil,lg,tp)
end
function c95493471.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c95493471.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c95493471.cfilter2(c,tp,zone)
	local seq=c:GetPreviousSequence()
	if c:IsPreviousControler(1-tp) then seq=seq+16 end
	return c:IsPreviousLocation(LOCATION_MZONE) and bit.extract(zone,seq)~=0 and c:IsType(TYPE_XYZ)
		and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)
end
function c95493471.spcon(e,tp,eg,ep,ev,re,r,rp)
	local zone=e:GetHandler():GetLinkedZone()
	local g=eg:Filter(c95493471.cfilter2,nil,tp,zone)
	local attr=0
	for tc in aux.Next(g) do
		attr=attr|tc:GetOriginalAttribute()
	end
	e:SetLabel(attr)
	return #g>0
end
function c95493471.spfilter(c,e,tp,attr)
	return c:IsSetCard(0xdc) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetOriginalAttribute()&attr>0
end
function c95493471.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c95493471.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,e:GetLabel()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c95493471.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c95493471.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,e:GetLabel())
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
