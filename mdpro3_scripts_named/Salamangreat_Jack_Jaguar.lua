--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 转生炎兽 灯火美洲豹  (ID: 56003780)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Cyberse
-- Level 4
-- ATK 1800 | DEF 1200
-- Setcode: 281
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
-- ②：这张卡在墓地存在，自己场上有「转生炎兽」连接怪兽存在的场合，以「转生炎兽 灯火美洲豹」以外的自己墓地1只「转生炎兽」怪兽为对象才能发动。那只怪兽回到卡组，墓地的这张卡在作为自己的「转生炎兽」连接怪
-- 兽所连接区的自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣Jジャガー
function c56003780.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56003780,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,56003780)
	e2:SetCondition(c56003780.spcon)
	e2:SetTarget(c56003780.sptg)
	e2:SetOperation(c56003780.spop)
	c:RegisterEffect(e2)
end
function c56003780.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x119) and c:IsType(TYPE_LINK)
end
function c56003780.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c56003780.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c56003780.tdfilter(c)
	return c:IsSetCard(0x119) and c:IsType(TYPE_MONSTER) and not c:IsCode(56003780) and c:IsAbleToDeck()
end
function c56003780.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c56003780.tdfilter(chkc) end
	local g=Duel.GetMatchingGroup(c56003780.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()<=0 then return false end
	local zone=0
	for tc in aux.Next(g) do
		zone=bit.bor(zone,tc:GetLinkedZone(tp))
	end
	zone=bit.band(zone,0x1f)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
		and Duel.IsExistingTarget(c56003780.tdfilter,tp,LOCATION_GRAVE,0,1,nil)
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=Duel.SelectTarget(tp,c56003780.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c56003780.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_DECK+LOCATION_EXTRA) and e:GetHandler():IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c56003780.filter,tp,LOCATION_MZONE,0,nil)
		if g:GetCount()<=0 then return end
		local zone=0
		for tc in aux.Next(g) do
			zone=bit.bor(zone,tc:GetLinkedZone(tp))
		end
		zone=bit.band(zone,0x1f)
		if zone==0 then return end
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
