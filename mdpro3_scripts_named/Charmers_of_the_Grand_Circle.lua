--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 大轮之灵使  (ID: 48016074)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 6
-- ATK 1850 | DEF 1500
-- Setcode: 191
--
-- Effect Text:
-- 「灵使」、「凭依装着」怪兽×2只以上
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡融合召唤的场合才能发动。让最多有作为这张卡的融合素材的怪兽的原本属性种类数量的「从以下效果选1个，那个效果适用」处理重复（最多4次）。
-- ●这张卡的攻击力上升800。
-- ●从卡组把1张「凭依」魔法·陷阱卡加入手卡。
-- ●场上1张卡回到手卡。
-- ●从自己墓地把1只魔法师族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--大輪の霊使い
local s,id,o=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep2(c,s.ffilter,2,127,true)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--material check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(s.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function s.ffilter(c,fc)
	return c:IsFusionSetCard(0xbf,0x10c0)
end
function s.valcheck(e,c)
	local ct=c:GetMaterial():GetClassCount(Card.GetOriginalAttribute)
	e:GetLabelObject():SetLabel(ct)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetLabel()
	if chk==0 then return ct>0 end
end
function s.thfilter(c)
	return c:IsSetCard(0xc0) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function s.spfilter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	if ct<=0 then return end
	if ct>4 then ct=4 end
	for i=1,ct do
		local b1=c:IsRelateToChain() and c:IsFaceup() and c:IsType(TYPE_MONSTER)
		local b2=Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil)
		local b3=Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		local b4=Duel.IsExistingMatchingCard(aux.NecroValleyFilter(s.spfilter),tp,LOCATION_GRAVE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		local b5=i>1
		if not b1 and not b2 and not b3 and not b4 then break end
		local op=aux.SelectFromOptions(tp,
			{b1,aux.Stringid(id,1),1},
			{b2,aux.Stringid(id,2),2},
			{b3,aux.Stringid(id,3),3},
			{b4,aux.Stringid(id,4),4},
			{b5,aux.Stringid(id,5),5})
		if i>1 and op~=5 then
			Duel.BreakEffect()
		end
		if op==1 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
			e1:SetValue(800)
			c:RegisterEffect(e1)
		elseif op==2 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
			if g:GetCount()>0 then
				Duel.SendtoHand(g,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,g)
			end
		elseif op==3 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
			local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
			if g:GetCount()>0 then
				Duel.HintSelection(g)
				Duel.SendtoHand(g,nil,REASON_EFFECT)
			end
		elseif op==4 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
			if g:GetCount()>0 then
				Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
			end
		elseif op==5 then
			break
		end
	end
end
