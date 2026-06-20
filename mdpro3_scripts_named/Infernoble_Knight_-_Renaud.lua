--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 焰圣骑士-里纳尔多  (ID: 56824871)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 1
-- ATK 500 | DEF 200
-- Setcode: 20602
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己场上有战士族·炎属性怪兽存在的场合，这张卡可以从手卡特殊召唤。这个方法特殊召唤的这张卡当作调整使用。
-- ②：这张卡特殊召唤成功的场合，从自己墓地的卡以及除外的自己的卡之中以「焰圣骑士-里纳尔多」以外的1只战士族·炎属性怪兽或者1张装备魔法卡为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--焔聖騎士－リナルド
function c56824871.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,56824871+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c56824871.sprcon)
	e1:SetOperation(c56824871.sprop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56824871,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,56824872)
	e2:SetTarget(c56824871.thtg)
	e2:SetOperation(c56824871.thop)
	c:RegisterEffect(e2)
end
c56824871.treat_itself_tuner=true
function c56824871.sprfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR) and c:IsAttribute(ATTRIBUTE_FIRE)
end
function c56824871.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c56824871.sprfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c56824871.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetValue(TYPE_TUNER)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
	c:RegisterEffect(e1)
end
function c56824871.thfilter(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
		and ((c:IsRace(RACE_WARRIOR) and c:IsAttribute(ATTRIBUTE_FIRE) and not c:IsCode(56824871)) or c:IsType(TYPE_EQUIP)) and c:IsAbleToHand()
end
function c56824871.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c56824871.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c56824871.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c56824871.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c56824871.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
