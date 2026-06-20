--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔界剧团-圆熟女主演  (ID: 78310590)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- ATK 1800 | DEF 2500
-- Setcode: 4332
--
-- Effect Text:
-- ←0 【灵摆】 0→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：支付1000基本分才能发动。从卡组把「魔界剧团-圆熟女主演」以外的1只「魔界剧团」灵摆怪兽加入手卡。这个效果的发动后，直到回合结束时自己不是「魔界剧团」灵摆怪兽不能特殊召唤。
-- 【怪兽效果】
-- 这个卡名的①③的怪兽效果1回合各能使用1次。
-- ①：自己的灵摆怪兽被战斗破坏时才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡的攻击力上升自己墓地的「魔界台本」魔法卡数量×100。
-- ③：「魔界台本」魔法卡的效果发动的场合才能发动。从卡组把1只4星以下的「魔界剧团」灵摆怪兽特殊召唤。这个效果特殊召唤的怪兽在结束阶段回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--魔界劇団－メロー・マドンナ
function c78310590.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78310590,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,78310590)
	e1:SetCost(c78310590.thcost)
	e1:SetTarget(c78310590.thtg)
	e1:SetOperation(c78310590.thop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c78310590.val)
	c:RegisterEffect(e2)
	--spsummon (self)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(78310590,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetRange(LOCATION_HAND)
	e3:SetCountLimit(1,78310591)
	e3:SetCondition(c78310590.spcon)
	e3:SetTarget(c78310590.sptg)
	e3:SetOperation(c78310590.spop)
	c:RegisterEffect(e3)
	--spsummon (deck)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(78310590,2))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_CHAINING)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,78310592)
	e5:SetCondition(c78310590.spcon2)
	e5:SetTarget(c78310590.sptg2)
	e5:SetOperation(c78310590.spop2)
	c:RegisterEffect(e5)
end
function c78310590.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c78310590.thfilter(c)
	return c:IsSetCard(0x10ec) and not c:IsCode(78310590) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c78310590.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c78310590.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c78310590.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c78310590.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c78310590.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c78310590.splimit(e,c)
	return not (c:IsSetCard(0x10ec) and c:IsType(TYPE_PENDULUM))
end
function c78310590.valfilter(c)
	return c:IsSetCard(0x20ec) and c:IsType(TYPE_SPELL)
end
function c78310590.val(e,c)
	return Duel.GetMatchingGroupCount(c78310590.valfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*100
end
function c78310590.cfilter(c,tp)
	return c:IsType(TYPE_PENDULUM) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
end
function c78310590.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c78310590.cfilter,1,nil,tp)
end
function c78310590.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c78310590.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c78310590.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsSetCard(0x20ec)
end
function c78310590.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x10ec) and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c78310590.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c78310590.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c78310590.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c78310590.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		local fid=c:GetFieldID()
		tc:RegisterFlagEffect(78310590,RESET_EVENT+RESETS_STANDARD,0,1,fid)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetLabel(fid)
		e1:SetLabelObject(tc)
		e1:SetCondition(c78310590.thcon2)
		e1:SetOperation(c78310590.thop2)
		Duel.RegisterEffect(e1,tp)
	end
end
function c78310590.thcon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(78310590)~=e:GetLabel() then
		e:Reset()
		return false
	else return true end
end
function c78310590.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetLabelObject(),nil,REASON_EFFECT)
end
