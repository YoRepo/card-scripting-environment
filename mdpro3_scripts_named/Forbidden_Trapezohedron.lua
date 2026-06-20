--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 禁断的偏方面体  (ID: 49033797)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「禁断的偏方面体」在1回合只能发动1张。
-- ①：自己场上的融合·同调·超量怪兽只有那之内2种类的场合，那个组合的以下效果适用。
-- ●融合·同调怪兽：从额外卡组把1只「外神」超量怪兽特殊召唤，把这张卡在下面重叠作为超量素材。
-- ●同调·超量怪兽：从额外卡组把1只「旧神」融合怪兽特殊召唤。
-- ●超量·融合怪兽：从额外卡组把1只「古神」同调怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--禁断のトラペゾヘドロン
function c49033797.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,49033797+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c49033797.target)
	e1:SetOperation(c49033797.activate)
	c:RegisterEffect(e1)
end
function c49033797.cfilter(c,tpe)
	return c:IsFaceup() and c:IsType(tpe)
end
function c49033797.filter(c,e,tp,cat)
	return c:IsSetCard(cat) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c49033797.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local flag=0
		if Duel.IsExistingMatchingCard(c49033797.cfilter,tp,LOCATION_MZONE,0,1,nil,TYPE_FUSION) then flag=flag+1 end
		if Duel.IsExistingMatchingCard(c49033797.cfilter,tp,LOCATION_MZONE,0,1,nil,TYPE_SYNCHRO) then flag=flag+2 end
		if Duel.IsExistingMatchingCard(c49033797.cfilter,tp,LOCATION_MZONE,0,1,nil,TYPE_XYZ) then flag=flag+4 end
		if flag==3 then
			return e:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsExistingMatchingCard(c49033797.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,0xb6)
				and e:GetHandler():IsCanOverlay()
		elseif flag==6 then
			return Duel.IsExistingMatchingCard(c49033797.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,0xb7)
		elseif flag==5 then
			return Duel.IsExistingMatchingCard(c49033797.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,0xb8)
		else return false end
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c49033797.activate(e,tp,eg,ep,ev,re,r,rp)
	local flag=0
	if Duel.IsExistingMatchingCard(c49033797.cfilter,tp,LOCATION_MZONE,0,1,nil,TYPE_FUSION) then flag=flag+1 end
	if Duel.IsExistingMatchingCard(c49033797.cfilter,tp,LOCATION_MZONE,0,1,nil,TYPE_SYNCHRO) then flag=flag+2 end
	if Duel.IsExistingMatchingCard(c49033797.cfilter,tp,LOCATION_MZONE,0,1,nil,TYPE_XYZ) then flag=flag+4 end
	if flag==3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c49033797.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,0xb6)
		local sc=g:GetFirst()
		if sc then
			Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
			local c=e:GetHandler()
			if c:IsRelateToEffect(e) and c:IsCanOverlay() then
				c:CancelToGrave()
				Duel.Overlay(sc,Group.FromCards(c))
			end
		end
	elseif flag==6 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c49033797.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,0xb7)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	elseif flag==5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c49033797.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,0xb8)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
