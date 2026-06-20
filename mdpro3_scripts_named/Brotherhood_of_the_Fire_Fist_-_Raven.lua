--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 捷炎星-清鸦  (ID: 44860890)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level 3
-- ATK 200 | DEF 1800
-- Setcode: 121
--
-- Effect Text:
-- 这张卡从场上送去墓地的场合，可以从卡组选1张名字带有「炎舞」的魔法卡在自己场上盖放。此外，只要这张卡在场上表侧表示存在，自己场上的名字带有「炎舞」的魔法·陷阱卡不会被对方的卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--捷炎星－セイヴン
function c44860890.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44860890,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_SSET)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c44860890.setcon)
	e1:SetTarget(c44860890.settg)
	e1:SetOperation(c44860890.setop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(c44860890.indtg)
	e2:SetValue(c44860890.indval)
	c:RegisterEffect(e2)
end
function c44860890.setcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c44860890.filter(c)
	return c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c44860890.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44860890.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c44860890.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c44860890.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
function c44860890.indtg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c44860890.indval(e,re,tp)
	return e:GetHandler():GetControler()~=tp
end
