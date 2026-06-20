--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 发条拧紧  (ID: 83319610)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡的①②的效果在同一连锁上不能发动。
-- ①：1回合1次，以自己场上1只机械族超量怪兽为对象才能发动。选自己的手卡·场上1只「发条」怪兽在作为对象的怪兽下面重叠作为超量素材。
-- ②：把魔法与陷阱区域的表侧表示的这张卡送去墓地，以自己场上1只「发条」超量怪兽为对象才能发动。比那只自己怪兽阶级高1阶的1只「发条」超量怪兽在那上面重叠当作超量召唤从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--発条の巻き上げ
function c83319610.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83319610,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetTarget(c83319610.mttg)
	e2:SetOperation(c83319610.mtop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(83319610,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCost(c83319610.spcost)
	e3:SetTarget(c83319610.sptg)
	e3:SetOperation(c83319610.spop)
	c:RegisterEffect(e3)
end
function c83319610.filter1(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsRace(RACE_MACHINE)
		and Duel.IsExistingMatchingCard(c83319610.filter2,tp,LOCATION_HAND+LOCATION_MZONE,0,1,c)
end
function c83319610.filter2(c,e)
	return c:IsSetCard(0x58) and c:IsType(TYPE_MONSTER) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsCanOverlay() and not (e and c:IsImmuneToEffect(e))
end
function c83319610.mttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c83319610.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c83319610.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c83319610.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
end
function c83319610.mtop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c83319610.filter2,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,tc,e)
	if g:GetCount()>0 then
		local mg=g:GetFirst():GetOverlayGroup()
		if mg:GetCount()>0 then
			Duel.SendtoGrave(mg,REASON_RULE)
		end
		Duel.Overlay(tc,g)
	end
end
function c83319610.spfilter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x58) and c:IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c83319610.spfilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,c:GetRank()+1)
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function c83319610.spfilter2(c,e,tp,mc,rk)
	return c:IsRank(rk) and c:IsSetCard(0x58) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c83319610.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c83319610.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c83319610.spfilter1(chkc,e,tp) end
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.IsExistingTarget(c83319610.spfilter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c83319610.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c83319610.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c83319610.spfilter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+1)
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
