--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 龙之秘宝  (ID: 1435851)
-- Type: Spell / Field
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 龙族才能装备。1只装备怪兽的攻击力·守备力上升300。
--[[ __CARD_HEADER_END__ ]]

--ドラゴンの秘宝
function c1435851.initial_effect(c)
	aux.AddEquipSpellEffect(c,true,true,c1435851.filter,c1435851.eqlimit)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--def up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(300)
	c:RegisterEffect(e3)
end
function c1435851.eqlimit(e,c)
	return c:IsRace(RACE_DRAGON)
end
function c1435851.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c1435851.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c1435851.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1435851.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c1435851.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c1435851.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
