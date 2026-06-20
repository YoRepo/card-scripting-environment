--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 装甲电子翼  (ID: 67159705)
-- Type: Monster / Effect / Union
-- Attribute: WIND
-- Race: Machine
-- Level 4
-- ATK 0 | DEF 2000
-- Setcode: 147
--
-- Effect Text:
-- ①：1回合1次，可以从以下效果选择1个发动。
-- ●以自己场上1只需以「电子龙」为素材的融合怪兽或者「电子龙」为对象，把这张卡当作装备卡使用给那只怪兽装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备的这张卡特殊召唤。
-- ②：1回合1次，以场上1只表侧表示怪兽为对象才能发动。装备怪兽的攻击力下降1000，作为对象的表侧表示怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--アーマード・サイバーン
function c67159705.initial_effect(c)
	aux.EnableUnionAttribute(c,c67159705.filter)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(67159705,2))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c67159705.destg)
	e5:SetOperation(c67159705.desop)
	c:RegisterEffect(e5)
end
function c67159705.filter(c)
	return c:IsCode(70095154) or c:IsType(TYPE_FUSION) and aux.IsMaterialListCode(c,70095154)
end
function c67159705.desfilter(c)
	return c:IsFaceup()
end
function c67159705.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c67159705.desfilter(chkc) end
	if chk==0 then return e:GetHandler():GetEquipTarget() and e:GetHandler():GetEquipTarget():GetAttack()>=1000
		and Duel.IsExistingTarget(c67159705.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c67159705.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c67159705.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ec=c:GetEquipTarget()
	if ec:GetAttack()<1000 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-1000)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	ec:RegisterEffect(e1)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not ec:IsHasEffect(EFFECT_REVERSE_UPDATE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
