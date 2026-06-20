--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 极星天 凡娜迪丝  (ID: 61777313)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Fairy
-- Level 4
-- ATK 1200 | DEF 400
-- Setcode: 12354
--
-- Effect Text:
-- 这张卡可以作为「极星」调整的代替而成为同调素材。把这张卡作为同调素材的场合，其他的同调素材怪兽必须全部是「极星」怪兽。
-- ①：1回合1次，把持有和这张卡的等级不同等级的1只「极星」怪兽从卡组送去墓地才能发动。这张卡的等级直到回合结束时变成和送去墓地的怪兽相同。
--[[ __CARD_HEADER_END__ ]]

--極星天ヴァナディース
function c61777313.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TUNER_MATERIAL_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c61777313.synlimit)
	c:RegisterEffect(e1)
	--level change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(61777313,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c61777313.cost)
	e2:SetOperation(c61777313.operation)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(61777313)
	c:RegisterEffect(e3)
end
function c61777313.synlimit(e,c)
	return c:IsSetCard(0x42)
end
function c61777313.cfilter(c,lv)
	return c:IsSetCard(0x42) and c:IsType(TYPE_MONSTER) and not c:IsLevel(lv) and c:IsLevelAbove(1) and c:IsAbleToGraveAsCost()
end
function c61777313.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c61777313.cfilter,tp,LOCATION_DECK,0,1,nil,e:GetHandler():GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c61777313.cfilter,tp,LOCATION_DECK,0,1,1,nil,e:GetHandler():GetLevel())
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetFirst():GetLevel())
end
function c61777313.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(e:GetLabel())
		c:RegisterEffect(e1)
	end
end
