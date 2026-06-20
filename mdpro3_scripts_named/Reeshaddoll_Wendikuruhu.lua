--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 影灵翼骑 影文蒂  (ID: 8852158)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Psychic
-- Level 6
-- ATK 200 | DEF 2800
-- Setcode: 157
--
-- Effect Text:
-- 「影依」怪兽＋风属性怪兽
-- 这张卡用融合召唤才能从额外卡组特殊召唤。这个卡名的①的效果1回合只能使用1次。
-- ①：自己·对方回合可以发动。场上的里侧表示怪兽任意数量变成表侧守备表示。那之后，可以把最多有那之内的反转怪兽数量的除变成表侧守备表示的怪兽以外的表侧表示怪兽变成里侧守备表示。
-- ②：这张卡被送去墓地的场合，以自己墓地1张「影依」卡为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--影霊翼騎 ウェンディクルフ
local s,id,o=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	--fusion
	aux.AddFusionProcShaddoll(c,ATTRIBUTE_WIND)
	--cannot spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetValue(s.splimit)
	c:RegisterEffect(e1)
	--poschange
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.postg)
	e2:SetOperation(s.posop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetTarget(s.thtg)
	e3:SetOperation(s.thop)
	c:RegisterEffect(e3)
end
function s.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function s.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,0,PLAYER_ALL,0)
end
function s.posop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #dg==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local fg=Duel.SelectMatchingCard(tp,Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,1,#dg,nil)
	if #fg>0 then
		Duel.HintSelection(fg)
		Duel.ChangePosition(fg,POS_FACEUP_DEFENSE)
	end
	local fct=fg:FilterCount(Card.IsType,nil,TYPE_FLIP)
	if fct>0 then
		local tg=Duel.GetMatchingGroup(aux.AND(Card.IsFaceup,Card.IsCanTurnSet),tp,LOCATION_MZONE,LOCATION_MZONE,fg)
		if #tg>0 and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
			local sg=tg:Select(tp,1,math.min(fct,#tg),nil)
			if #sg>0 then
				Duel.BreakEffect()
				Duel.HintSelection(sg)
				Duel.ChangePosition(sg,POS_FACEDOWN_DEFENSE)
			end
		end
	end
end
function s.thfilter(c)
	return c:IsSetCard(0x9d) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,s.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() and aux.NecroValleyFilter(tc) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
