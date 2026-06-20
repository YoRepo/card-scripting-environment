--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 升阶魔法-异晶人的魔力  (ID: 47660516)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 24510613
--
-- Effect Text:
-- ①：以自己场上1只超量怪兽为对象才能发动。和那只自己怪兽相同种族而阶级高1阶的1只「混沌No.」怪兽或「混沌超量」怪兽在作为对象的怪兽上面重叠当作超量召唤从额外卡组特殊召唤。对方场上有超量素材存在的场
-- 合，再把那之内的1个作为那只特殊召唤的怪兽的超量素材。
--[[ __CARD_HEADER_END__ ]]

--RUM－バリアンズ・フォース
function c47660516.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c47660516.target)
	e1:SetOperation(c47660516.activate)
	c:RegisterEffect(e1)
end
function c47660516.filter1(c,e,tp)
	local rk=c:GetRank()
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c47660516.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,rk+1,c:GetRace(),c:GetCode())
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function c47660516.filter2(c,e,tp,mc,rk,rc,code)
	if c:GetOriginalCode()==6165656 and code~=48995978 then return false end
	return c:IsRank(rk) and c:IsRace(rc) and c:IsSetCard(0x1048,0x1073) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c47660516.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c47660516.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c47660516.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c47660516.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c47660516.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c47660516.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+1,tc:GetRace(),tc:GetCode())
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
		if Duel.GetOverlayCount(tp,0,1)~=0 then
			Duel.BreakEffect()
			local g1=Duel.GetOverlayGroup(tp,0,1)
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(47660516,0))
			local mg2=g1:Select(tp,1,1,nil)
			local oc=mg2:GetFirst():GetOverlayTarget()
			Duel.Overlay(sc,mg2)
			Duel.RaiseSingleEvent(oc,EVENT_DETACH_MATERIAL,e,0,0,0,0)
			Duel.RaiseEvent(oc,EVENT_DETACH_MATERIAL,e,0,0,0,0)
		end
	end
end
