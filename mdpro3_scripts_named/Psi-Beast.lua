--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 念动力兽  (ID: 46291010)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Psychic
-- Level 2
-- ATK 700 | DEF 500
--
-- Effect Text:
-- ①：这张卡召唤成功时才能发动。从卡组把1只念动力族怪兽除外。这张卡的等级变成和这个效果除外的怪兽的等级相同。
--[[ __CARD_HEADER_END__ ]]

--サイキック・ビースト
function c46291010.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46291010,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c46291010.rmtg)
	e1:SetOperation(c46291010.rmop)
	c:RegisterEffect(e1)
end
function c46291010.filter(c)
	return c:IsRace(RACE_PSYCHO) and c:IsLevelAbove(1) and c:IsAbleToRemove()
end
function c46291010.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c46291010.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c46291010.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c46291010.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0
		and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
end
