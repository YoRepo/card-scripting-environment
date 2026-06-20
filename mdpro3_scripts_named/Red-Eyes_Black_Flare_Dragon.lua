--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 真红眼黑炎龙  (ID: 30079770)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Dragon
-- Level 7
-- ATK 2400 | DEF 2000
-- Setcode: 59
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡进行战斗的战斗阶段结束时才能发动。给与对方这张卡的原本攻击力数值的伤害。「真红眼黑炎龙」的这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--真紅眼の黒炎竜
function c30079770.initial_effect(c)
	aux.EnableDualAttribute(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1,30079770)
	e1:SetCondition(c30079770.damcon)
	e1:SetTarget(c30079770.damtg)
	e1:SetOperation(c30079770.damop)
	c:RegisterEffect(e1)
end
function c30079770.damcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.IsDualState(e) and e:GetHandler():GetBattledGroupCount()>0
end
function c30079770.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local atk=e:GetHandler():GetBaseAttack()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c30079770.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local atk=c:GetBaseAttack()
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end
