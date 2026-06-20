--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 龙骑兵团-司令官  (ID: 89172051)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1800 | DEF 1200
-- Setcode: 41
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡在手卡存在，自己场上有「龙骑兵团」怪兽或「龙之溪谷」存在的场合才能发动。这张卡特殊召唤。
-- ②：自己的魔法与陷阱区域有「龙骑兵团」怪兽卡存在的场合，以场上1张魔法·陷阱卡为对象才能发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－レガトゥス
function c89172051.initial_effect(c)
	aux.AddCodeList(c,62265044)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89172051,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,89172051)
	e1:SetCondition(c89172051.spcon)
	e1:SetTarget(c89172051.sptg)
	e1:SetOperation(c89172051.spop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(89172051,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,89172052)
	e2:SetCondition(c89172051.descon)
	e2:SetTarget(c89172051.destg)
	e2:SetOperation(c89172051.desop)
	c:RegisterEffect(e2)
end
function c89172051.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x29)
end
function c89172051.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(62265044,tp) or Duel.IsExistingMatchingCard(c89172051.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c89172051.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c89172051.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c89172051.cfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x29) and c:GetOriginalType()&TYPE_MONSTER>0
end
function c89172051.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c89172051.cfilter2,tp,LOCATION_SZONE,0,1,nil)
end
function c89172051.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c89172051.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c89172051.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c89172051.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c89172051.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c89172051.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
