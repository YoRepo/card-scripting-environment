--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 红血鬼  (ID: 30494314)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 4
-- ATK 1700 | DEF 1000
--
-- Effect Text:
-- 这张卡用不死族怪兽的效果从墓地的特殊召唤成功时，选择自己场上1只不死族怪兽才能发动。把场上1个超量素材取除，选择的怪兽的等级上升1星，攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--紅血鬼
function c30494314.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30494314,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c30494314.condition)
	e1:SetTarget(c30494314.target)
	e1:SetOperation(c30494314.operation)
	c:RegisterEffect(e1)
end
function c30494314.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local typ,race=c:GetSpecialSummonInfo(SUMMON_INFO_TYPE,SUMMON_INFO_RACE)
	return c:IsPreviousLocation(LOCATION_GRAVE) and typ&TYPE_MONSTER~=0 and race&RACE_ZOMBIE~=0
end
function c30494314.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE) and c:IsLevelAbove(0)
end
function c30494314.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c30494314.filter(chkc) end
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,1,1,REASON_EFFECT)
		and Duel.IsExistingTarget(c30494314.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c30494314.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c30494314.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DEATTACHFROM)
	local sg=Duel.SelectMatchingCard(tp,Card.CheckRemoveOverlayCard,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp,1,REASON_EFFECT)
	if sg:GetCount()==0 then return end
	sg:GetFirst():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(300)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
end
