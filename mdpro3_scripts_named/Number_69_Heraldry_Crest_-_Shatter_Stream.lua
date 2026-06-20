--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: No.69 纹章神 盾徽-神之粉碎  (ID: 31086840)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Psychic
-- Rank 4
-- ATK 2800 | DEF 1600
-- Setcode: 4718738
--
-- Effect Text:
-- 4星怪兽×4
-- 这张卡也能在原本卡名是「No.69 纹章神 盾徽」的自己场上的怪兽上面重叠来超量召唤。这个卡名的效果1回合只能使用1次。
-- ①：对方场上的怪兽把效果发动时或者对方怪兽的攻击宣言时才能发动。把1只「No.69 纹章神 盾徽-神之愤怒」在自己场上的这张卡上面重叠当作超量召唤从额外卡组特殊召唤。那之后，那1只对方怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--No.69 紋章神コート・オブ・アームズ－ゴッド・シャーター
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,2407234,77571454)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,4,s.ovfilter,aux.Stringid(id,0))
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(s.spcon2)
	e2:SetTarget(s.sptg2)
	e2:SetOperation(s.spop2)
	c:RegisterEffect(e2)
end
aux.xyz_number[id]=69
function s.ovfilter(c)
	return c:IsFaceup() and c:IsOriginalCodeRule(2407234)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.GetAttacker():IsOnField() then return false end
	e:SetLabelObject(Duel.GetAttacker())
	return Duel.GetAttacker():GetControler()~=tp
end
function s.spfilter(c,e,tp,mc)
	return c:IsCode(77571454) and c:IsType(TYPE_XYZ) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ac=e:GetLabelObject()
	if chk==0 then return aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,ac,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ac=e:GetLabelObject()
	if not aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if c:IsFaceup() and c:IsRelateToEffect(e) and c:IsControler(tp) and not c:IsImmuneToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,c)
		local sc=g:GetFirst()
		if sc then
			local mg=c:GetOverlayGroup()
			if mg:GetCount()~=0 then
				Duel.Overlay(sc,mg)
			end
			sc:SetMaterial(Group.FromCards(c))
			Duel.Overlay(sc,Group.FromCards(c))
			Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			sc:CompleteProcedure()
		end
		if ac:IsRelateToBattle() and ac:IsControler(1-tp) and ac:IsType(TYPE_MONSTER) then
			Duel.BreakEffect()
			Duel.Destroy(ac,REASON_EFFECT)
		end
	end
end
function s.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep==1-tp and re:GetHandler():IsOnField() and re:GetHandler():IsRelateToEffect(re) and re:IsActiveType(TYPE_MONSTER)
end
function s.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
end
function s.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if c:IsFaceup() and c:IsRelateToEffect(e) and c:IsControler(tp) and not c:IsImmuneToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,c)
		local sc=g:GetFirst()
		if sc then
			local mg=c:GetOverlayGroup()
			if mg:GetCount()~=0 then
				Duel.Overlay(sc,mg)
			end
			sc:SetMaterial(Group.FromCards(c))
			Duel.Overlay(sc,Group.FromCards(c))
			Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			sc:CompleteProcedure()
		end
		if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsFaceup() and re:GetHandler():IsControler(1-tp) then
			Duel.BreakEffect()
			Duel.Destroy(eg,REASON_EFFECT)
		end
	end
end
