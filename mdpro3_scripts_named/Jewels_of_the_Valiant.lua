--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 星邪的神食  (ID: 72710085)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 只让自己墓地的怪兽1只被从游戏中除外的场合，可以把和除外的那只怪兽不同属性的1只怪兽从卡组送去墓地。「星邪的神食」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--星邪の神喰
function c72710085.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72710085,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCountLimit(1,72710085)
	e2:SetCondition(c72710085.tgcon)
	e2:SetTarget(c72710085.tgtg)
	e2:SetOperation(c72710085.tgop)
	c:RegisterEffect(e2)
end
function c72710085.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:IsPreviousLocation(LOCATION_GRAVE) and tc:IsControler(tp) and tc:IsType(TYPE_MONSTER)
end
function c72710085.filter(c,att)
	return not c:IsAttribute(att) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c72710085.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72710085.filter,tp,LOCATION_DECK,0,1,nil,eg:GetFirst():GetAttribute()) end
	e:SetLabel(eg:GetFirst():GetAttribute())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c72710085.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c72710085.filter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabel())
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
