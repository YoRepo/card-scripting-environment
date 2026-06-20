--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 神影依·米沙赫雷恶  (ID: 32467459)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level 10
-- ATK 2800 | DEF 1000
-- Setcode: 157
--
-- Effect Text:
-- 「影依」怪兽＋暗属性怪兽＋地属性怪兽
-- 这张卡不用融合召唤不能特殊召唤。
-- ①：场上的这张卡不受对方发动的魔法·陷阱卡的效果影响，也不受原本的等级·阶级的数值比这张卡的等级低的对方怪兽发动的效果影响。
-- ②：1回合1次，支付800基本分才能发动。从卡组把1张「影依」卡或「炼狱」魔法·陷阱卡加入手卡。
-- ③：这张卡被送去墓地的场合才能发动。从自己墓地把1只「影依」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エルシャドール・メシャフレール
local s,id,o=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	--fusion
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(s.FShaddollCondition)
	e0:SetOperation(s.FShaddollOperation)
	c:RegisterEffect(e0)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetValue(s.efilter)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(s.thcost)
	e3:SetTarget(s.thtg)
	e3:SetOperation(s.thop)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetTarget(s.sptg)
	e4:SetOperation(s.spop)
	c:RegisterEffect(e4)
end
function s.efilter(e,te)
	if te:GetHandlerPlayer()==e:GetHandlerPlayer() or not te:IsActivated() then
		return false
	end
	if te:IsActiveType(TYPE_SPELL+TYPE_TRAP) then
		return true
	else
		return aux.qlifilter(e,te)
	end
end
function s.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function s.thfilter(c)
	return (c:IsSetCard(0x9d) or c:IsSetCard(0xc5) and c:IsType(TYPE_SPELL+TYPE_TRAP)) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x9d) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function s.FShaddollFilter(c,fc)
	return (c:IsFusionSetCard(0x9d) or c:IsFusionAttribute(ATTRIBUTE_DARK+ATTRIBUTE_EARTH) or c:IsHasEffect(4904633))
		and c:IsCanBeFusionMaterial(fc) and not c:IsHasEffect(6205579)
end
function s.FShaddollExFilter(c,fc,fe)
	return c:IsFaceup() and not c:IsImmuneToEffect(fe) and s.FShaddollFilter(c,fc)
end
function s.FShaddollFilter1(c,g)
	return c:IsFusionSetCard(0x9d) and g:IsExists(s.FShaddollFilter2,1,c,g,c)
end
function s.FShaddollFilter2(c,g,gc)
	return (c:IsFusionAttribute(ATTRIBUTE_DARK) or c:IsHasEffect(4904633))
		and g:IsExists(s.FShaddollFilter3,1,Group.FromCards(c,gc))
end
function s.FShaddollFilter3(c)
	return c:IsFusionAttribute(ATTRIBUTE_EARTH) or c:IsHasEffect(4904633)
end
function s.FShaddollCheck(g,gc,fc,tp,c,chkf,exg)
	if gc and not g:IsContains(gc) then return false end
	if exg and g:FilterCount(aux.IsInGroup,nil,exg)>1 then return false end
	if g:IsExists(aux.TuneMagicianCheckX,1,nil,g,EFFECT_TUNE_MAGICIAN_F) then return false end
	if not aux.MustMaterialCheck(g,tp,EFFECT_MUST_BE_FMATERIAL) then return false end
	if aux.FCheckAdditional and not aux.FCheckAdditional(tp,g,fc)
		or aux.FGoalCheckAdditional and not aux.FGoalCheckAdditional(tp,g,fc) then return false end
	return g:IsExists(s.FShaddollFilter1,1,nil,g)
		and (chkf==PLAYER_NONE or Duel.GetLocationCountFromEx(tp,tp,g,fc)>0)
end
function s.FShaddollCondition(e,g,gc,chkf)
	if g==nil then return aux.MustMaterialCheck(nil,e:GetHandlerPlayer(),EFFECT_MUST_BE_FMATERIAL) end
	local c=e:GetHandler()
	local mg=g:Filter(s.FShaddollFilter,nil,c)
	local tp=e:GetHandlerPlayer()
	local fc=Duel.GetFieldCard(tp,LOCATION_FZONE,0)
	local exg=nil
	if fc and fc:IsHasEffect(81788994) and fc:IsCanRemoveCounter(tp,0x16,3,REASON_EFFECT) then
		local fe=fc:IsHasEffect(81788994)
		exg=Duel.GetMatchingGroup(s.FShaddollExFilter,tp,0,LOCATION_MZONE,mg,c,fe)
	end
	if exg then mg:Merge(exg) end
	if gc and not mg:IsContains(gc) then return false end
	return mg:CheckSubGroup(s.FShaddollCheck,3,3,gc,fc,tp,c,chkf,exg)
end
function s.FShaddollOperation(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local c=e:GetHandler()
	local mg=eg:Filter(s.FShaddollFilter,nil,c)
	local fc=Duel.GetFieldCard(tp,LOCATION_FZONE,0)
	local exg=nil
	if fc and fc:IsHasEffect(81788994) and fc:IsCanRemoveCounter(tp,0x16,3,REASON_EFFECT) then
		local fe=fc:IsHasEffect(81788994)
		exg=Duel.GetMatchingGroup(s.FShaddollExFilter,tp,0,LOCATION_MZONE,mg,c,fe)
	end
	if exg then mg:Merge(exg) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g=mg:SelectSubGroup(tp,s.FShaddollCheck,false,3,3,gc,c,tp,c,chkf,exg)
	if exg and g:IsExists(aux.IsInGroup,1,nil,exg) then
		fc:RemoveCounter(tp,0x16,3,REASON_EFFECT)
	end
	Duel.SetFusionMaterial(g)
end
