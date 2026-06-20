--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 凭依觉醒-螺旋龙  (ID: 410904)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level 5
-- ATK 2000 | DEF 200
-- Setcode: 192
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：这张卡可以把自己场上的表侧表示的1只魔法师族怪兽和1只4星以下的风属性怪兽送去墓地，从手卡·卡组特殊召唤。
-- ②：这张卡的①的方法特殊召唤时才能发动。对方场上1张卡回到手卡。
-- ③：这张卡从场上送去墓地的场合才能发动。从卡组把1张「风灵术」卡或「凭依」魔法·陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--憑依覚醒－ラセンリュウ
function c410904.initial_effect(c)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCondition(c410904.spcon)
	e1:SetTarget(c410904.sptg)
	e1:SetOperation(c410904.spop)
	e1:SetValue(SUMMON_VALUE_SELF)
	c:RegisterEffect(e1)
	--return to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(410904,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,410904)
	e2:SetCondition(c410904.condition)
	e2:SetTarget(c410904.rthtg)
	e2:SetOperation(c410904.rthop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(410904,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,410905)
	e3:SetCondition(c410904.thcon)
	e3:SetTarget(c410904.thtg)
	e3:SetOperation(c410904.thop)
	c:RegisterEffect(e3)
end
function c410904.spfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c410904.spfilter2(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsLevelBelow(4)
end
function c410904.fselect(g,tp)
	return aux.mzctcheck(g,tp) and aux.gffcheck(g,Card.IsRace,RACE_SPELLCASTER,c410904.spfilter2,nil)
end
function c410904.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c410904.spfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c410904.fselect,2,2,tp)
end
function c410904.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c410904.spfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,c410904.fselect,true,2,2,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c410904.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c410904.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end
function c410904.rthtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,1-tp,LOCATION_ONFIELD)
end
function c410904.rthop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c410904.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c410904.thfilter(c)
	return ((c:IsSetCard(0xc0) and c:IsType(TYPE_SPELL+TYPE_TRAP)) or c:IsSetCard(0x914c)) and c:IsAbleToHand()
end
function c410904.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c410904.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c410904.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c410904.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
