--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 死之代行者 乌拉诺斯  (ID: 97750534)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Fairy
-- Level 5
-- ATK 2200 | DEF 1200
-- Setcode: 68
--
-- Effect Text:
-- ①：场上有「天空的圣域」存在的场合，这张卡可以从手卡特殊召唤。
-- ②：1回合1次，自己主要阶段才能发动。从卡组把1只「代行者」怪兽送去墓地。这张卡的等级变成和那只怪兽的等级相同。
--[[ __CARD_HEADER_END__ ]]

--死の代行者 ウラヌス
function c97750534.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c97750534.spcon)
	c:RegisterEffect(e1)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(97750534,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c97750534.tgtg)
	e2:SetOperation(c97750534.tgop)
	c:RegisterEffect(e2)
end
function c97750534.spcon(e,c)
	if c==nil then return Duel.IsEnvironment(56433456) end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c97750534.filter(c)
	return c:IsSetCard(0x44) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c97750534.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97750534.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c97750534.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c97750534.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE) then
		local lv=tc:GetLevel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
