--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 帝王的策略  (ID: 63899196)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 190
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：从卡组把「帝王的策略」以外的1张「帝王」魔法·陷阱卡送去墓地。
-- ②：这张卡被除外的场合，以对方场上1只表侧表示怪兽为对象才能发动。属性和那只怪兽相同而攻击力2400/守备力1000的1只怪兽从自己的卡组·墓地加入手卡。那之后，以下效果可以适用。
-- ●进行「雷帝 扎博尔格」「冰帝 美比乌斯」「炎帝 泰斯塔罗斯」「地帝 格兰玛格」「风帝 莱扎」「邪帝 盖乌斯」的其中1只的召唤。
--[[ __CARD_HEADER_END__ ]]

--帝王の策略
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,4929256,9748752,26205777,51945556,60229110,73125233)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
end
function s.filter(c)
	return c:IsSetCard(0xbe) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(id) and c:IsAbleToGrave()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function s.thfilter(c,att)
	return c:IsAttack(2400) and c:IsDefense(1000) and c:IsAttribute(att)
		and c:IsAbleToHand()
end
function s.tgfilter(c,tp)
	local att=c:GetAttribute()
	return c:IsFaceup() and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,att)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return s.tgfilter(chkc,tp) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(s.tgfilter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,s.tgfilter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function s.sumfilter(c)
	return c:IsSummonable(true,nil) and c:IsCode(4929256,9748752,26205777,51945556,60229110,73125233)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToChain() or not tc:IsType(TYPE_MONSTER) or not tc:IsFaceup() then return end
	local att=tc:GetAttribute()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,att)
	if g:GetCount()>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,g)
		local sumg=Duel.GetMatchingGroup(s.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
		if sumg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local sc=sumg:Select(tp,1,1,nil):GetFirst()
			if sc then
				Duel.BreakEffect()
				Duel.ShuffleHand(tp)
				Duel.Summon(tp,sc,true,nil)
			end
		end
	end
end
