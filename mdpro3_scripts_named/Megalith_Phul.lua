--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 巨石遗物·富尔  (ID: 78990927)
-- Type: Monster / Effect / Ritual
-- Attribute: EARTH
-- Race: Rock
-- Level 2
-- ATK 500 | DEF 2000
-- Setcode: 312
--
-- Effect Text:
-- 「巨石遗物」卡降临
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡仪式召唤的场合，以自己墓地1只仪式怪兽为对象才能发动。这张卡的等级变成和那只怪兽相同。那之后，作为对象的怪兽加入手卡。
-- ②：自己·对方的主要阶段才能发动。等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡·卡组把1只「巨石遗物」仪式怪兽仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--メガリス・フール
function c78990927.initial_effect(c)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78990927,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,78990927)
	e1:SetCondition(c78990927.thcon)
	e1:SetTarget(c78990927.thtg)
	e1:SetOperation(c78990927.thop)
	c:RegisterEffect(e1)
	--ritual summon
	local e2=aux.AddRitualProcGreater2(c,c78990927.filter,LOCATION_HAND+LOCATION_DECK,nil,nil,true)
	e2:SetDescription(aux.Stringid(78990927,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetCountLimit(1,78990928)
	e2:SetCondition(c78990927.rscon)
	c:RegisterEffect(e2)
end
function c78990927.thfilter(c,lv)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER) and not c:IsLevel(lv) and c:IsAbleToHand()
end
function c78990927.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c78990927.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local lv=c:GetLevel()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c78990927.thfilter(chkc,lv) end
	if chk==0 then return c:IsLevelAbove(1) and c:IsRelateToEffect(e)
		and Duel.IsExistingTarget(c78990927.thfilter,tp,LOCATION_GRAVE,0,1,nil,lv) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c78990927.thfilter,tp,LOCATION_GRAVE,0,1,1,nil,lv)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c78990927.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		local lv=tc:GetLevel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		Duel.BreakEffect()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c78990927.filter(c,e,tp,chk)
	return c:IsSetCard(0x138)
end
function c78990927.rscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
