--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 超重武者 魂-C  (ID: 9402966)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Machine
-- Level 2
-- ATK 100 | DEF 800
-- Setcode: 154
--
-- Effect Text:
-- 「超重武者 魂-C」的效果1回合只能使用1次。
-- ①：自己场上没有「超重武者」怪兽以外的怪兽存在，自己墓地没有魔法·陷阱卡存在的场合，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽和这张卡从场上送去墓地。那之后，把持有和送去墓地的那2只怪兽的原本
-- 等级合计相同等级的1只「超重武者」同调怪兽从额外卡组当作同调召唤作特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--超重武者タマ－C
function c9402966.initial_effect(c)
	--synchro summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,9402966)
	e1:SetCondition(c9402966.sccon)
	e1:SetTarget(c9402966.sctg)
	e1:SetOperation(c9402966.scop)
	c:RegisterEffect(e1)
end
function c9402966.cfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0x9a)
end
function c9402966.sccon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c9402966.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c9402966.filter(c,e,tp,lv,mc)
	return c:IsFaceup() and c:GetLevel()>0
		and Duel.IsExistingMatchingCard(c9402966.scfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,lv+c:GetOriginalLevel(),Group.FromCards(c,mc))
end
function c9402966.scfilter(c,e,tp,lv,mg)
	return c:IsSetCard(0x9a) and c:IsLevel(lv) and c:IsType(TYPE_SYNCHRO)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mg,c)>0
end
function c9402966.sctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local c=e:GetHandler()
	local lv=c:GetOriginalLevel()
	if chk==0 then return Duel.IsExistingTarget(c9402966.filter,tp,0,LOCATION_MZONE,1,nil,e,tp,lv,c)
		and aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c9402966.filter,tp,0,LOCATION_MZONE,1,1,nil,e,tp,lv,c)
	g:AddCard(c)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c9402966.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL) then return end
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local g=Group.FromCards(c,tc)
	if Duel.SendtoGrave(g,REASON_EFFECT)==2 and c:GetLevel()>0 and c:IsLocation(LOCATION_GRAVE)
		and tc:GetLevel()>0 and tc:IsLocation(LOCATION_GRAVE) then
		local lv=c:GetLevel()+tc:GetLevel()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c9402966.scfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lv,nil)
		local tc=sg:GetFirst()
		if tc then
			Duel.BreakEffect()
			tc:SetMaterial(nil)
			if Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)>0 then
				tc:CompleteProcedure()
			end
		end
	end
end
