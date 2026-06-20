--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 占术姬 花瓣精灵  (ID: 68625727)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Fairy
-- Level 3
-- ATK 800 | DEF 700
-- Setcode: 204
--
-- Effect Text:
-- ①：这张卡反转的场合才能发动。对方场上的表侧攻击表示怪兽全部变成守备表示。这个效果变成守备表示的怪兽不能把表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--占術姫ペタルエルフ
function c68625727.initial_effect(c)
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c68625727.postg)
	e1:SetOperation(c68625727.posop)
	c:RegisterEffect(e1)
end
function c68625727.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c68625727.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c68625727.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c68625727.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c68625727.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c68625727.filter,tp,0,LOCATION_MZONE,nil)
	if Duel.ChangePosition(g,POS_FACEUP_DEFENSE)~=0 then
		local og=Duel.GetOperatedGroup()
		local oc=og:GetFirst()
		while oc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			oc:RegisterEffect(e1)
			oc=og:GetNext()
		end
	end
end
