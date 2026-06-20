--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 天空贤者 密涅瓦  (ID: 53666449)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1700 | DEF 400
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，每次自己或者对方把反击陷阱卡发动，这张卡的攻击力上升500，场上有「天空的圣域」存在的场合，再从自己墓地选和那张发动的反击陷阱卡卡名不同的1张反击陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--天空賢者ミネルヴァ
function c53666449.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--atk
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetCode(EVENT_CHAINING)
	e0:SetRange(LOCATION_MZONE)
	e0:SetOperation(aux.chainreg)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c53666449.atkcon)
	e1:SetOperation(c53666449.atkop)
	c:RegisterEffect(e1)
end
function c53666449.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_COUNTER) and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0
end
function c53666449.thfilter(c,code)
	return c:IsType(TYPE_COUNTER) and not c:IsCode(code) and c:IsAbleToHand()
end
function c53666449.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
	local rc=re:GetHandler()
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c53666449.thfilter),tp,LOCATION_GRAVE,0,nil,rc:GetCode())
	if Duel.IsEnvironment(56433456) and g:GetCount()>0 then
		Duel.Hint(HINT_CARD,0,53666449)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
