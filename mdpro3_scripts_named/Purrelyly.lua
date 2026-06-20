--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 纯爱妖精·夜妖精  (ID: 79933029)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 396
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。从卡组把速攻魔法卡以外的1张「纯爱妖精」卡加入手卡。
-- ②：以自己墓地1张「纯爱妖精」速攻魔法卡为对象才能发动。把有那个卡名记述的1只超量怪兽在自己场上的这张卡上面重叠当作超量召唤从额外卡组特殊召唤，把作为对象的卡在那只超量怪兽下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--ピュアリィ・リリィ
local s,id,o=GetID()
function s.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,id+o)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
end
function s.thfilter(c)
	return c:IsSetCard(0x18c) and c:IsAbleToHand() and not c:IsType(TYPE_QUICKPLAY)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.sptgexfilter(c,e,tp,code)
	local sc=e:GetHandler()
	return aux.IsCodeListed(c,code) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and c:IsType(TYPE_XYZ) and sc:IsCanBeXyzMaterial(c) and Duel.GetLocationCountFromEx(tp,tp,sc,c)>0
end
function s.sptgfilter(c,e,tp)
	return c:IsType(TYPE_QUICKPLAY) and c:IsSetCard(0x18c) and c:IsCanOverlay()
		and Duel.IsExistingMatchingCard(s.sptgexfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetCode())
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and s.sptgfilter(chkc,e,tp) end
	if chk==0 then return aux.MustMaterialCheck(e:GetHandler(),tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingTarget(s.sptgfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,s.sptgfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	local sc=Duel.GetFirstTarget()
	if not c:IsRelateToChain() or c:IsImmuneToEffect(e) or c:IsFacedown() or c:IsControler(1-tp) then return end
	if not sc:IsRelateToChain() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,s.sptgexfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,sc:GetCode())
	local tc=sg:GetFirst()
	if not tc then return end
	tc:SetMaterial(Group.FromCards(c))
	Duel.Overlay(tc,c)
	Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
	tc:CompleteProcedure()
	if not sc:IsImmuneToEffect(e) and sc:IsCanOverlay() then Duel.Overlay(tc,sc) end
end
