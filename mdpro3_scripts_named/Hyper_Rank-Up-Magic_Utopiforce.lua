--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 超升阶魔法-乌托邦之力  (ID: 67517351)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 149
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以自己场上1只9阶以下的「希望皇 霍普」超量怪兽为对象才能发动。把1只10阶以上的「霍普」超量怪兽在作为对象的自己的超量怪兽上面重叠当作超量召唤从额外卡组特殊召唤。
-- ②：这张卡在墓地存在的状态，10阶以上的「霍普」超量怪兽的效果让超量怪兽特殊召唤的场合，以那之内的1只为对象才能发动。把这张卡作为那只怪兽的超量素材。
--[[ __CARD_HEADER_END__ ]]

--HRUM－ユートピア・フォース
function c67517351.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67517351,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,67517351)
	e1:SetTarget(c67517351.target)
	e1:SetOperation(c67517351.activate)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67517351,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,67517352)
	e2:SetCondition(c67517351.matcon)
	e2:SetTarget(c67517351.mattg)
	e2:SetOperation(c67517351.matop)
	c:RegisterEffect(e2)
end
function c67517351.filter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x107f) and c:IsType(TYPE_XYZ) and c:IsRankBelow(9)
		and Duel.IsExistingMatchingCard(c67517351.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function c67517351.filter2(c,e,tp,mc)
	return c:IsRankAbove(10) and c:IsSetCard(0x7f) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c67517351.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c67517351.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c67517351.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c67517351.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c67517351.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c67517351.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
function c67517351.cfilter(c,e)
	local typ,rk=c:GetSpecialSummonInfo(SUMMON_INFO_TYPE,SUMMON_INFO_RANK)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsCanBeEffectTarget(e)
		and typ&TYPE_XYZ~=0 and rk>=10 and c:IsSpecialSummonSetCard(0x7f)
end
function c67517351.matcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c67517351.cfilter,1,nil,e)
end
function c67517351.tgfilter(c,eg)
	return eg:IsContains(c) and c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c67517351.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c67517351.tgfilter(chkc,eg) end
	if chk==0 then return Duel.IsExistingTarget(c67517351.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,eg)
		and e:GetHandler():IsCanOverlay() end
	if eg:GetCount()==1 then
		Duel.SetTargetCard(eg)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,c67517351.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,eg)
	end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c67517351.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
