--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 黑混沌之魔术师·黑混沌极魔导  (ID: 79613121)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Spellcaster
-- Level 8
-- ATK 2800 | DEF 2600
-- Setcode: 207
--
-- Effect Text:
-- 「混沌形态」降临。这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡特殊召唤成功的场合，把自己场上1只怪兽解放才能发动。这个回合，对方不能把怪兽的效果发动。
-- ②：这张卡战斗破坏对方怪兽时，以自己墓地1张魔法卡为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--マジシャン・オブ・ブラックカオス・MAX
function c79613121.initial_effect(c)
	aux.AddCodeList(c,21082832)
	c:EnableReviveLimit()
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79613121,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,79613121)
	e1:SetCost(c79613121.cost)
	e1:SetOperation(c79613121.sumsuc)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79613121,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,79613122)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(c79613121.thtg)
	e2:SetOperation(c79613121.thop)
	c:RegisterEffect(e2)
end
function c79613121.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c79613121.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(c79613121.actlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c79613121.actlimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c79613121.thfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c79613121.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c79613121.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c79613121.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c79613121.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c79613121.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
